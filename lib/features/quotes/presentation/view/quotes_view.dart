import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../quotes_cubit/quotes_cubit.dart';

import '../../data/models/quotes_model.dart';

class QuotesView extends StatefulWidget {
  const QuotesView({super.key});

  @override
  State<QuotesView> createState() => _QuotesViewState();
}

class _QuotesViewState extends State<QuotesView> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    context.read<QuotesCubit>().getIntialQuotes();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = context.read<QuotesCubit>();

    if (_isBottom && !cubit.isLoadingMore) {
      cubit.loadMoreQuotes();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<QuotesCubit, QuotesState>(
          builder: (context, state) {
            if (state is QuotesLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is QuotesError) {
              return Center(child: Text(state.message));
            }

            if (state is QuotesLoaded) {
              final quotes = state.quotes;
              log(quotes.length.toString());
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                controller: _scrollController,
                itemCount: quotes.length,
                itemBuilder: (context, index) {
                  final quote = quotes[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            '"${quote.quote}"',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '- ${quote.author ?? 'Unknown'}',
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (state is QuotesPaginationLoading) {
              final quotes = state.oldQuotes;
              return _buildQuotesList(quotes, true);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildQuotesList(List<QuoteModel> quotes, bool isLoadingMore) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      controller: _scrollController,
      itemCount: quotes.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= quotes.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final quote = quotes[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '"${quote.quote}"',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  '- ${quote.author ?? 'Unknown'}',
                  textAlign: TextAlign.right,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
